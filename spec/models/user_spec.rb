require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "Model Validations" do
    let(:user) { subject }

    describe 'name' do
      it 'accepts valid name' do
        user.name = 'Jane Doe'
        user.email = 'jane.doe@example.com'

        expect(user.valid?).to be true
      end

      it 'validates presence of name' do
        expect(user.valid?).to be false
        expect(user.errors[:name][0]).to eq('can\'t be blank')
      end

      it 'must be at least 5 characters' do
        user.name = 'a'

        expect(user.valid?).to be false
        expect(user.errors[:name][0]).to eq('is too short (minimum is 5 characters)')
      end

      it 'must be at most 50 characters' do
        user.name = 'a' * 51

        expect(user.valid?).to be false
        expect(user.errors[:name][0]).to eq('is too long (maximum is 50 characters)')
      end
    end

    describe 'email' do
      it 'accepts valid email addresses' do
        user.name = 'Jane Doe'
        valid_emails = %w[jane.doe@axample.com jane@bbc.com j432d@sample.com]

        valid_emails.each do |valid_email|
          user.email = valid_email
          expect(user.valid?).to be true
        end
      end

      it 'validates invalid email addresses' do
        user.name = 'Jane Doe'
        invalid_emails = %w[jane.doe@axample,com 2jan%e@bbc.com j432d@+com janedotcom]

        invalid_emails.each do |invalid_email|
          user.email = invalid_email
          expect(user.valid?).to be false
        end
      end

      it 'validates presence of email' do
        expect(user.valid?).to be false
        expect(user.errors[:email][0]).to eq('can\'t be blank')
      end

      it 'must be at most 255 characters' do
        user.email = 'janeatexampledotcom' * 50

        expect(user.valid?).to be false
        expect(user.errors[:email][0]).to eq('is too long (maximum is 255 characters)')
      end

      it 'validates uniqueness of email address' do
        user = create(:user, name: 'Jane Doe', email: 'jane.doe@example.com')
        duplicate_user = user.dup
        duplicate_user.email.upcase!

        expect(duplicate_user.valid?).to be false
        expect(duplicate_user.errors[:email][0]).to eq('has already been taken')
      end
    end
  end

  describe 'callbacks' do
    describe '#downcase_email'
      let(:email) { 'JaNeDoE@eXaMpLe.CoM' }
      let(:user) { build(:user, email: email) }

      it 'converts emails to downcase characters before saving' do
        expect(user.email).to eq(email)

        user.save

        expect(user.email).to eq(email.downcase)
      end
  end
end
