FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'test0000'}
    password_confirmation {password}
    team                  {'テスト'}
    position              {'player'}
  end
end
