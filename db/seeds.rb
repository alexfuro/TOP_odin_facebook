# Create some basic users
joe   =  User.create!(name: "joe", email: "joe@email.com",
                      password: "password", password_confirmation: "password")

maria =  User.create!(name: "maria", email: "maria@email.com",
                      password: "password", password_confirmation: "password")

dave  =  User.create!(name: "dave", email: "dave@email.com",
                      password: "password", password_confirmation: "password")

julia =  User.create!(name: "julia", email: "julia@email.com",
                      password: "password", password_confirmation: "password")

bama  =  User.create!(name: "bama", email: "bama@email.com",
                      password: "password", password_confirmation: "password")

loner =  User.create!(name: "loner", email: "loner@email.com",
                      password: "password", password_confirmation: "password")

# Create some friend requests
joe.sent_requests.create(requested_id: maria.id)
joe.sent_requests.create(requested_id: dave.id, accepted: true)
joe.sent_requests.create(requested_id: bama.id, accepted: false)

dave.sent_requests.create(requested_id: julia.id)
dave.sent_requests.create(requested_id: bama.id, accepted: true)
dave.sent_requests.create(requested_id: joe.id,  accepted: true)

julia.sent_requests.create(requested_id: joe.id)
julia.sent_requests.create(requested_id: dave.id, accepted: false)
julia.sent_requests.create(requested_id: maria.id, accepted: true)

bama.sent_requests.create(requested_id: dave.id, accepted: true)

maria.sent_requests.create(requested_id: julia.id, accepted: true)

#create some posts
joe.posts.create(content: "Yo this is a sentence joe")
dave.posts.create(content: "Yo this is a sentence dave")
julia.posts.create(content: "Yo this is a sentence julia")
