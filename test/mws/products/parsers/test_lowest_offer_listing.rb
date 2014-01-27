require 'parser_helper'
require 'mws/products/parsers/lowest_offer_listing'

class LowestOfferListingParserTest < ParserTest

  def setup
    node = fixture_from_cassette('offer_listings_test/test_get_lower_for_sku').xpath('//xmlns:LowestOfferListing')
    @lowest_offer_listing = MWS::Products::Parsers::LowestOfferListing.new(node)
  end

  [:offer_listings_considered_count, :seller_feedback_count].each do |method|
    define_method "test_#{method}" do
      assert_kind_of Integer, @lowest_offer_listing.public_send(method)
    end
  end

  def test_multiple_offers
    assert_kind_of FalseClass, @lowest_offer_listing.multiple_offers
  end
end
