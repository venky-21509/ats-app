# db/seeds.rb

puts "Cleaning database..."
Reminder.destroy_all
Note.destroy_all
Application.destroy_all
Job.destroy_all
User.destroy_all
Company.destroy_all

puts "Creating companies..."
acme = Company.create!(
  name: "Acme Corp",
  industry: "Technology",
  website: "https://acmecorp.com",
  description: "A leading technology company building the future."
)

globex = Company.create!(
  name: "Globex Corporation",
  industry: "Engineering",
  website: "https://globex.com",
  description: "World class engineering solutions since 1990."
)

puts "Creating admin user..."
admin = User.create!(
  email: "admin@acme.com",
  password: "password123",
  first_name: "Admin",
  last_name: "User",
  role: :admin,
  company: acme
)

puts "Creating staff users..."
staff1 = User.create!(
  email: "sarah@acme.com",
  password: "password123",
  first_name: "Sarah",
  last_name: "Connor",
  role: :staff,
  company: acme
)

staff2 = User.create!(
  email: "john@globex.com",
  password: "password123",
  first_name: "John",
  last_name: "Smith",
  role: :staff,
  company: globex
)

puts "Creating candidate users..."
candidate1 = User.create!(
  email: "alice@gmail.com",
  password: "password123",
  first_name: "Alice",
  last_name: "Johnson",
  role: :candidate
)

candidate2 = User.create!(
  email: "bob@gmail.com",
  password: "password123",
  first_name: "Bob",
  last_name: "Williams",
  role: :candidate
)

candidate3 = User.create!(
  email: "carol@gmail.com",
  password: "password123",
  first_name: "Carol",
  last_name: "Davis",
  role: :candidate
)

puts "Creating jobs..."
job1 = Job.create!(
  company: acme,
  creator: admin,
  title: "Senior Rails Developer",
  description: "We are looking for an experienced Rails developer to join our team. You will be responsible for building and maintaining our core platform.\n\nRequirements:\n- 3+ years of Rails experience\n- Strong understanding of PostgreSQL\n- Experience with RESTful APIs",
  location: "Remote",
  job_type: :full_time,
  status: :open,
  closes_at: 30.days.from_now
)

job2 = Job.create!(
  company: acme,
  creator: staff1,
  title: "Frontend Engineer",
  description: "Join our frontend team to build beautiful, responsive user interfaces.\n\nRequirements:\n- Strong JavaScript skills\n- Experience with React or Vue\n- Eye for design",
  location: "New York, NY",
  job_type: :full_time,
  status: :open,
  closes_at: 20.days.from_now
)

job3 = Job.create!(
  company: globex,
  creator: staff2,
  title: "DevOps Engineer",
  description: "Help us scale our infrastructure and improve our deployment pipelines.\n\nRequirements:\n- Experience with AWS or GCP\n- Strong knowledge of Docker and Kubernetes\n- CI/CD pipeline experience",
  location: "San Francisco, CA",
  job_type: :full_time,
  status: :open,
  closes_at: 15.days.from_now
)

job4 = Job.create!(
  company: acme,
  creator: admin,
  title: "Junior Developer Intern",
  description: "Great opportunity for students or recent graduates to get hands-on experience.",
  location: "Remote",
  job_type: :internship,
  status: :closed
)

puts "Creating applications..."
app1 = Application.create!(
  job: job1,
  user: candidate1,
  status: :interview,
  cover_letter: "I am very excited about this opportunity at Acme Corp. I have 4 years of Rails experience and have built several production applications.",
  resume_url: "https://example.com/alice-resume.pdf",
  applied_at: 5.days.ago
)

app2 = Application.create!(
  job: job1,
  user: candidate2,
  status: :screening,
  cover_letter: "Rails has been my primary framework for the past 3 years. I am confident I can contribute greatly to your team.",
  resume_url: "https://example.com/bob-resume.pdf",
  applied_at: 3.days.ago
)

app3 = Application.create!(
  job: job2,
  user: candidate3,
  status: :applied,
  cover_letter: "I am a passionate frontend developer with strong React skills and a great eye for UI design.",
  resume_url: "https://example.com/carol-resume.pdf",
  applied_at: 2.days.ago
)

app4 = Application.create!(
  job: job3,
  user: candidate1,
  status: :offer,
  cover_letter: "I have extensive DevOps experience with AWS and have led infrastructure migrations for two startups.",
  resume_url: "https://example.com/alice-resume.pdf",
  applied_at: 10.days.ago
)

puts "Creating notes..."
Note.create!(
  application: app1,
  author: staff1,
  body: "Alice had a great first interview. Strong technical skills, very articulate. Recommend moving to final round."
)

Note.create!(
  application: app1,
  author: admin,
  body: "Checked references — all positive. Good culture fit based on initial screening."
)

Note.create!(
  application: app2,
  author: staff1,
  body: "Bob's resume looks solid. Schedule a screening call for next week."
)

Note.create!(
  application: app4,
  author: staff2,
  body: "Alice is a strong candidate. Preparing offer letter — salary range $120k-$140k."
)

puts "Creating reminders..."
Reminder.create!(
  application: app1,
  creator: staff1,
  message: "Follow up with Alice after technical interview",
  remind_at: 2.days.from_now,
  sent: false
)

Reminder.create!(
  application: app2,
  creator: staff1,
  message: "Schedule screening call with Bob",
  remind_at: 1.day.from_now,
  sent: false
)

puts ""
puts "Seed data created successfully!"
puts ""
puts "Login credentials:"
puts "Admin:      admin@acme.com     / password123"
puts "Staff:      sarah@acme.com     / password123"
puts "Staff:      john@globex.com    / password123"
puts "Candidate:  alice@gmail.com    / password123"
puts "Candidate:  bob@gmail.com      / password123"
puts "Candidate:  carol@gmail.com    / password123"