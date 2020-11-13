# frozen_string_literal: true

require 'rails_helper'

describe User do
  subject do
    described_class.new(email: 'testymctestface@example.com',
                        first_name: 'Testy',
                        last_name: 'McTestface')
  end

  describe 'Associations' do
    it { should have_many(:auth_tokens) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end
  end
end
