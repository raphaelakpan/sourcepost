require 'rails_helper'

RSpec.describe StaticPagesController do
  describe 'GET home' do
    it 'renders the home page' do
      get :home

      expect(response.status).to be 200
    end
  end

  describe 'GET help' do
    it 'renders the help page' do
      get :help

      expect(response.status).to be 200
    end
  end
  describe 'GET about' do
    it 'renders the about page' do
      get :about

      expect(response.status).to be 200
    end
  end
end
