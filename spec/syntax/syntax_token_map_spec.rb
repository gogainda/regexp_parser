require 'spec_helper'

RSpec.describe(Regexp::Syntax::Token::Map) do
  let(:map) { Regexp::Syntax::Token::Map }
  let(:latest_syntax) { Regexp::Syntax::V3_2_0 }

  specify('is complete') do
    latest_syntax.features.each do |type, tokens|
      tokens.each { |token| expect(map[type]).to include(token) }
    end
  end

  specify('contains no duplicate tokens') do
    latest_syntax.features.each do |_type, tokens|
      expect(tokens).to eq tokens.uniq
    end
  end

  specify('contains no duplicate type/token combinations') do
    combinations = map.flat_map do |type, tokens|
      tokens.map { |token| "#{type} #{token}" }
    end

    non_uniq = combinations.group_by { |str| str }.select { |_, v| v.count > 1 }

    expect(non_uniq.keys).to be_empty
  end
end
