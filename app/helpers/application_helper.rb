module ApplicationHelper
  def actions(&block)
    content_for :actions, &block
  end
end
