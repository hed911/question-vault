class SyncDataJob < ApplicationJob
  def perform(id)
    integration = Integration.find_by(id:)
    return if integration.nil?

    orchestator = BulkDataImporter::ResilientOrchestator.new(integration)
    orchestator.start
  end
end
