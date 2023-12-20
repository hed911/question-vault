require 'rails_helper'

RSpec.describe Models::IntegrationsFactory, type: :model do
  it 'should return a notion integration object' do
    expect(Models::IntegrationsFactory.from_type('notion').class).to eq NotionIntegration
  end

  it 'should raise an exception when type is not found' do
    expect { Models::IntegrationsFactory.from_type('something') }.to raise_error(StandardError)
  end
end
