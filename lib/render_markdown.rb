module RenderMarkdown
  extend self

  RENDERER = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    tables:              true,
    autolink:            true,
    superscript:         true,
    strikethrough:       true,
    no_intra_emphasis:   true,
    fenced_code_blocks:  true,
    space_after_headers: true,
  )

  def to_html(text)
    RENDERER.render text
  end
end

