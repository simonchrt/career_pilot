import React from 'react';

// Composant pour les cartes de statistiques
const StatCard = ({ title, value, color }) => (
  <div className="bg-white rounded-lg shadow p-6 text-center">
    <p className={`text-3xl font-bold text-${color}-600`}>{value}</p>
    <p className="text-sm text-gray-500">{title}</p>
  </div>
);

// Composant pour afficher le badge de statut
const StatusBadge = ({ status }) => {
  const getStatusColor = (status) => {
    switch (status) {
      case 'bookmarked': return 'bg-purple-100 text-purple-800';
      case 'applying': return 'bg-gray-100 text-gray-800';
      case 'applied': return 'bg-blue-100 text-blue-800';
      case 'screening': return 'bg-yellow-100 text-yellow-800';
      case 'interviewing': return 'bg-yellow-100 text-yellow-800';
      case 'offer': return 'bg-green-100 text-green-800';
      case 'rejected': return 'bg-red-100 text-red-800';
      case 'accepted': return 'bg-indigo-100 text-indigo-800';
      case 'withdrawn': return 'bg-gray-100 text-gray-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  return (
    <span className={`text-xs px-2 py-1 rounded-full ${getStatusColor(status)}`}>
      {status.charAt(0).toUpperCase() + status.slice(1)}
    </span>
  );
};

// Composant pour la section de candidatures récentes
const RecentApplications = ({ applications }) => (
  <div className="bg-white rounded-lg shadow p-6">
    <h2 className="text-lg font-medium text-gray-900 mb-4">Candidatures récentes</h2>
    {applications && applications.length > 0 ? (
      <>
        <ul className="divide-y divide-gray-200">
          {applications.map(app => (
            <li key={app.id} className="py-3">
              <div>
                <p className="font-medium text-gray-900">{app.job_listing.title}</p>
                <p className="text-sm text-gray-500">{app.job_listing.company.name}</p>
                <div className="flex items-center mt-1">
                  <StatusBadge status={app.status} />
                  {app.applied_date && (
                    <span className="text-xs text-gray-500 ml-2">
                      {new Date(app.applied_date).toLocaleDateString()}
                    </span>
                  )}
                </div>
              </div>
            </li>
          ))}
        </ul>
        <div className="mt-4 text-right">
          <a href="/applications" className="text-sm text-blue-600 hover:text-blue-800">
            Voir toutes
          </a>
        </div>
      </>
    ) : (
      <>
        <p className="text-center text-gray-500 py-4">Aucune candidature récente</p>
        <div className="text-center mt-4">
          <a href="/job_listings" className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700">
            Ajouter une candidature
          </a>
        </div>
      </>
    )}
  </div>
);

// Composant pour les technologies les plus recherchées
const TopTechnologies = ({ technologies }) => (
  <div className="bg-white rounded-lg shadow p-6">
    <h2 className="text-lg font-medium text-gray-900 mb-4">Technologies recherchées</h2>
    {technologies && technologies.length > 0 ? (
      <ul className="space-y-2">
        {technologies.map(tech => (
          <li key={tech.id} className="flex items-center justify-between">
            <span className="text-gray-700">{tech.name}</span>
            <span className="text-sm bg-blue-100 text-blue-800 py-1 px-2 rounded-full">
              {tech.count} offres
            </span>
          </li>
        ))}
      </ul>
    ) : (
      <p className="text-center text-gray-500 py-4">Aucune donnée disponible</p>
    )}
  </div>
);

// Composant pour les actions à venir
const UpcomingSteps = ({ steps }) => (
  <div className="bg-white rounded-lg shadow p-6">
    <h2 className="text-lg font-medium text-gray-900 mb-4">Actions à suivre</h2>
    {steps && steps.length > 0 ? (
      <>
        <ul className="divide-y divide-gray-200">
          {steps.map(step => (
            <li key={step.id} className="py-3">
              <div>
                <p className="font-medium text-gray-900">
                  {step.application.job_listing.title}
                </p>
                <p className="text-sm text-gray-500">
                  {step.application.job_listing.company.name}
                </p>
                <div className="flex items-center justify-between mt-1">
                  <span className="text-xs px-2 py-1 rounded-full bg-blue-100 text-blue-800">
                    {step.step_type.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}
                  </span>
                  {step.next_action_date && (
                    <span className="text-xs bg-yellow-100 text-yellow-800 py-1 px-2 rounded-full">
                      {new Date(step.next_action_date).toLocaleDateString()}
                    </span>
                  )}
                </div>
              </div>
            </li>
          ))}
        </ul>
        <div className="mt-4 text-right">
          <a href="/applications" className="text-sm text-blue-600 hover:text-blue-800">
            Voir toutes
          </a>
        </div>
      </>
    ) : (
      <p className="text-center text-gray-500 py-4">Aucune action à venir</p>
    )}
  </div>
);

// Composant principal du tableau de bord
const Dashboard = (props) => {
  const { stats, recentApplications, technologies, upcomingSteps } = props;

  return (
    <div className="dashboard">
      {/* Statistiques */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
        <StatCard title="Total" value={stats.totalApplications} color="blue" />
        <StatCard title="En cours" value={stats.pendingApplications} color="yellow" />
        <StatCard title="Acceptées" value={stats.acceptedApplications} color="green" />
        <StatCard title="Refusées" value={stats.rejectedApplications} color="red" />
      </div>

      {/* Trois sections d'informations */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <RecentApplications applications={recentApplications} />
        <TopTechnologies technologies={technologies} />
        <UpcomingSteps steps={upcomingSteps} />
      </div>
    </div>
  );
};

export default Dashboard;
