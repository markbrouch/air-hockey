# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def auth_token
    return unless bearer_token

    AuthToken.find_by_jwt(bearer_token)
  end

  def current_user
    return unless auth_token

    auth_token.user
  end

  def execute
    auth_token&.update(last_ip: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'])
    auth_token&.touch(:last_accessed_at)

    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      auth_token: auth_token,
      current_user: current_user
    }
    result = ApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
