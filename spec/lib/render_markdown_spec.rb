require 'spec_helper'

describe RenderMarkdown do
  it "converts to html" do
    text = %Q(
# Title
**strong**
_italic_)

    html = %Q(<h1>Title</h1>

<p><strong>strong</strong>
<em>italic</em></p>
)

    expect(RenderMarkdown.to_html(text)).to eq html
  end
end
