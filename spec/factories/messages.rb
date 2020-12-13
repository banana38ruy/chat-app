FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |message|
    message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      #afterメソッドは任意の処理のあとに指定の処理を実行することができる
      #例えば、after(:build)とすることで、インスタンスがbuildされたあとに指定の処理を実行することができる
      #io:File.open で設定したパスのファイル（public/images/test_image.png)を、test_image.pngというファイル名で保存している
   end
 end
end