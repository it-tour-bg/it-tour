class Photo < ActiveRecord::Base
  belongs_to :event

  validates :asset, presence: true
  validates :event, presence: true

  mount_uploader :asset, PhotoAssetUploader

  before_create :set_position
  after_destroy :remove_position

  scope :ordered, -> { order 'position ASC' }

  def as_json(options = {})
    {id: id, asset_url: asset.url(:thumb)}
  end

  private

  def set_position
    self.position = event.photos.pluck('MAX(position)').first.to_i + 1 if position.blank?
  end

  def remove_position
    event.photos.where('position > ?', position).update_all 'position = position - 1'
  end
end
