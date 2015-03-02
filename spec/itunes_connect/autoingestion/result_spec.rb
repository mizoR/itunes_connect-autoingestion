require 'spec_helper'

describe ItunesConnect::Autoingestion::Result do
  let(:data) {
    path = File.join(__dir__, '../../static/data.tsv')
    open(path).read
  }

  before do
    @result = described_class.new(data)
  end

  it do
    @result.each do |row|
      expect(row.developer).to        be_a(String)
      expect(row.apple_identifier).to be_a(String)
      expect(row.country_code).to     be_a(String)
    end
  end
end
