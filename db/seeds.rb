# Nettoyer la base de données existante
puts "Nettoyage de la base de données..."
ApplicationStep.destroy_all
Application.destroy_all
JobTechnology.destroy_all
Technology.destroy_all
JobListing.destroy_all
Company.destroy_all
OauthProvider.destroy_all
User.destroy_all

# Créer un utilisateur de test
puts "Création d'un utilisateur de test..."
user = User.create!(
  email: 'test@example.com',
  password: 'password',
  first_name: 'Jean',
  last_name: 'Dupont',
  username: 'jeandupont',
  profile_completed: true
)

# Créer des entreprises
puts "Création d'entreprises..."
companies = [
  {name: 'Google', website: 'https://google.com', industry: 'Tech', location: 'Paris', size: 'large'},
  {name: 'Facebook', website: 'https://facebook.com', industry: 'Tech', location: 'Paris', size: 'large'},
  {name: 'Amazon', website: 'https://amazon.com', industry: 'E-commerce', location: 'Paris', size: 'large'},
  {name: 'Netflix', website: 'https://netflix.com', industry: 'Entertainment', location: 'Paris', size: 'large'},
  {name: 'Startup XYZ', website: 'https://xyz.com', industry: 'Tech', location: 'Lyon', size: 'small'}
]

created_companies = companies.map do |company_data|
  Company.create!(company_data)
end

# Créer des technologies
puts "Création de technologies..."
technologies = [
  {name: 'Ruby', category: 'language'},
  {name: 'Rails', category: 'framework'},
  {name: 'JavaScript', category: 'language'},
  {name: 'React', category: 'library'},
  {name: 'Vue.js', category: 'framework'},
  {name: 'PostgreSQL', category: 'database'},
  {name: 'MongoDB', category: 'database'},
  {name: 'Docker', category: 'tool'},
  {name: 'AWS', category: 'platform'},
  {name: 'Git', category: 'tool'}
]

created_technologies = technologies.map do |tech_data|
  Technology.create!(tech_data)
end

# Créer des offres d'emploi
puts "Création d'offres d'emploi..."
job_listings = [
  {
    title: 'Développeur Ruby on Rails',
    description: 'Nous recherchons un développeur Ruby on Rails expérimenté pour rejoindre notre équipe.',
    company: created_companies[0],
    remote: true,
    salary_min: 45000,
    salary_max: 60000,
    currency: 'EUR',
    contract_type: 'full_time'
  },
  {
    title: 'Développeur Frontend React',
    description: 'Nous recherchons un développeur frontend pour travailler sur nos applications React.',
    company: created_companies[1],
    remote: true,
    salary_min: 40000,
    salary_max: 55000,
    currency: 'EUR',
    contract_type: 'full_time'
  },
  {
    title: 'Développeur Fullstack',
    description: 'Nous recherchons un développeur fullstack pour travailler sur nos applications.',
    company: created_companies[2],
    remote: false,
    salary_min: 50000,
    salary_max: 70000,
    currency: 'EUR',
    contract_type: 'full_time'
  },
  {
    title: 'DevOps Engineer',
    description: 'Nous recherchons un ingénieur DevOps pour nous aider à améliorer notre infrastructure.',
    company: created_companies[3],
    remote: true,
    salary_min: 55000,
    salary_max: 75000,
    currency: 'EUR',
    contract_type: 'full_time'
  },
  {
    title: 'Junior Developer',
    description: 'Nous recherchons un développeur junior pour rejoindre notre équipe.',
    company: created_companies[4],
    remote: false,
    salary_min: 35000,
    salary_max: 42000,
    currency: 'EUR',
    contract_type: 'full_time'
  }
]

created_job_listings = job_listings.map do |job_data|
  JobListing.create!(job_data)
end

# Associer des technologies aux offres d'emploi
puts "Association des technologies aux offres d'emploi..."
created_job_listings[0].technologies << created_technologies[0] # Ruby
created_job_listings[0].technologies << created_technologies[1] # Rails
created_job_listings[0].technologies << created_technologies[5] # PostgreSQL

created_job_listings[1].technologies << created_technologies[2] # JavaScript
created_job_listings[1].technologies << created_technologies[3] # React

created_job_listings[2].technologies << created_technologies[0] # Ruby
created_job_listings[2].technologies << created_technologies[1] # Rails
created_job_listings[2].technologies << created_technologies[2] # JavaScript
created_job_listings[2].technologies << created_technologies[3] # React

created_job_listings[3].technologies << created_technologies[7] # Docker
created_job_listings[3].technologies << created_technologies[8] # AWS

created_job_listings[4].technologies << created_technologies[0] # Ruby
created_job_listings[4].technologies << created_technologies[1] # Rails

# Créer des candidatures
puts "Création des candidatures..."
applications = [
  {
    user: user,
    job_listing: created_job_listings[0],
    status: 'applied',
    applied_date: 30.days.ago.to_date,
    response_date: 25.days.ago.to_date,
    notes: 'Entretien prévu dans une semaine'
  },
  {
    user: user,
    job_listing: created_job_listings[1],
    status: 'interviewing',
    applied_date: 20.days.ago.to_date,
    response_date: 15.days.ago.to_date,
    interview_date: 10.days.ago.to_date,
    notes: 'Premier entretien effectué, en attente du deuxième'
  },
  {
    user: user,
    job_listing: created_job_listings[2],
    status: 'rejected',
    applied_date: 40.days.ago.to_date,
    response_date: 30.days.ago.to_date,
    notes: 'Profil ne correspondant pas aux attentes'
  },
  {
    user: user,
    job_listing: created_job_listings[3],
    status: 'offer',
    applied_date: 60.days.ago.to_date,
    response_date: 50.days.ago.to_date,
    interview_date: 40.days.ago.to_date,
    notes: 'Offre reçue, en cours de négociation'
  },
  {
    user: user,
    job_listing: created_job_listings[4],
    status: 'bookmarked',
    notes: 'Intéressant pour plus tard'
  }
]

created_applications = applications.map do |app_data|
  Application.create!(app_data)
end

# Créer des étapes pour les candidatures
puts "Création des étapes de candidature..."
application_steps = [
  {
    application: created_applications[0],
    step_type: 'application_sent',
    date: 30.days.ago,
    completed: true,
    notes: 'Candidature envoyée via le site de l\'entreprise'
  },
  {
    application: created_applications[0],
    step_type: 'phone_screening',
    date: 25.days.ago,
    completed: true,
    notes: 'Entretien téléphonique avec RH'
  },
  {
    application: created_applications[0],
    step_type: 'technical_interview',
    date: 3.days.from_now,
    completed: false,
    next_action_date: 3.days.from_now.to_date,
    notes: 'Entretien technique à préparer'
  },
  {
    application: created_applications[1],
    step_type: 'application_sent',
    date: 20.days.ago,
    completed: true,
    notes: 'Candidature envoyée'
  },
  {
    application: created_applications[1],
    step_type: 'phone_screening',
    date: 15.days.ago,
    completed: true,
    notes: 'Entretien téléphonique effectué'
  },
  {
    application: created_applications[1],
    step_type: 'technical_interview',
    date: 10.days.ago,
    completed: true,
    notes: 'Entretien technique effectué'
  },
  {
    application: created_applications[1],
    step_type: 'hr_interview',
    date: 2.days.from_now,
    completed: false,
    next_action_date: 2.days.from_now.to_date,
    notes: 'Entretien avec le responsable d\'équipe'
  },
  {
    application: created_applications[3],
    step_type: 'application_sent',
    date: 60.days.ago,
    completed: true,
    notes: 'Candidature envoyée'
  },
  {
    application: created_applications[3],
    step_type: 'phone_screening',
    date: 55.days.ago,
    completed: true,
    notes: 'Entretien téléphonique effectué'
  },
  {
    application: created_applications[3],
    step_type: 'technical_interview',
    date: 50.days.ago,
    completed: true,
    notes: 'Entretien technique effectué'
  },
  {
    application: created_applications[3],
    step_type: 'offer_received',
    date: 40.days.ago,
    completed: true,
    notes: 'Offre reçue'
  },
  {
    application: created_applications[3],
    step_type: 'negotiation',
    date: 5.days.from_now,
    completed: false,
    next_action_date: 5.days.from_now.to_date,
    notes: 'Négociation du salaire'
  }
]

application_steps.each do |step_data|
  ApplicationStep.create!(step_data)
end

puts "Seed terminé avec succès!"
