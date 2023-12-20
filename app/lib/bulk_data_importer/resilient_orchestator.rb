class BulkDataImporter::ResilientOrchestator
  def initialize(integration, max_retries = ENV['MAX_RETRIES'].to_i)
    @orchestator = BulkDataImporter::Orchestator.new(integration)
    @max_retries = max_retries
    @retries = 0
    @errors = []
    @is_valid = false
  end

  def start
    @is_valid = try(:start)
    result
  end

  def result
    {
      is_valid: @is_valid,
      errors: @errors
    }
  end

  def method_missing(method, *args)
    return super unless @orchestator.respond_to?(method)

    @orchestator.send(method, *args)
  end

  private

  def try(method_name)
    @orchestator.send(method_name)
    true
  rescue Notion::APIResponseError => e
    store_error(e)

    if @retries <= @max_retries
      @retries += 1
      try(method_name)
    else
      @retries = 0
      false
    end
  end

  def store_error(e)
    message = "[BULK DATA IMPORTER TRY ##{@retries}] Exception #{e.class}: #{e.message}"
    @errors << message
    Rails.logger.error message
  end
end