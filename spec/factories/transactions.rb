FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { (0..9).to_a.map(&:to_s).sample }
    credit_card_date { '01/22' }
    result { "success" }
  end
end
