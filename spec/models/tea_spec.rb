require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_and_belong_to_many :subscription }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :image }
    it { should validate_presence_of :link }
  end
end
