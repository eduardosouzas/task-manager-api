FactoryGirl.define do
  factory :task do
    title "MyString"
    description "MyText"
    done false
    deadline "2017-11-23 02:11:22"
    user nil
  end
end
