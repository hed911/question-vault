module DataUtils
  extend ActiveSupport::Concern
  
  private

  def set_difficulty_levels
    @difficulty_levels = [
      { id: 'any', text: 'Any' },
      { id: 'easy', text: 'Easy' },
      { id: 'medium', text: 'Medium' },
      { id: 'hard', text: 'Hard' }
    ]
  end

  def set_statuses
    @statuses = [
      { id: 'any', text: 'Any' },
      { id: 'active', text: 'Active' },
      { id: 'archived', text: 'Archived' }
    ]
  end

  def set_sources(include_local: true)
    @sources = [
      { id: 'any', text: 'Any' },
      { id: 'local', text: 'Local' },
      *external_integrations
    ]
    @sources.delete_at(1) unless include_local
  end
end