require 'rspec'
require_relative '../lib/fortrak/table_formatter'

describe TableFormatter do
  let(:table) do
    TableFormatter.format([
      ['10 letters!', '9 letters', '8letters', '7letter'],
      ['7letter', '8letters', '9 letters', '10 letters!'],
      ['10 letters!', '9 letters', '8letters', '7letter'],
      ['10 letters!', '9 letters', '8letters', '7letter']
    ], " | ")
  end
  let(:formatted) do
    %Q{| 10 letters! | 9 letters | 8letters  | 7letter     |
| 7letter     | 8letters  | 9 letters | 10 letters! |
| 10 letters! | 9 letters | 8letters  | 7letter     |
| 10 letters! | 9 letters | 8letters  | 7letter     |}
  end

  it "formats 2d array into a string with even column lengths" do
    expect(table.lines[0].length).to eq table.lines[1].length
    expect(table).to eq formatted
  end
end
