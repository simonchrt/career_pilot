import React, { useState, useEffect } from 'react';

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
    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getStatusColor(status)}`}>
      {status.charAt(0).toUpperCase() + status.slice(1)}
    </span>
  );
};

const ApplicationCard = ({ application }) => {
  const formatDate = (dateString) => {
    if (!dateString) return 'Non précisé';
    return new Date(dateString).toLocaleDateString('fr-FR', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  return (
    <li>
      <a href={`/applications/${application.id}`} className="block hover:bg-gray-50">
        <div className="px-4 py-4 sm:px-6">
          <div className="flex items-center justify-between">
            <div className="text-sm font-medium text-blue-600 truncate">
              {application.job_listing.title}
            </div>
            <div className="ml-2 flex-shrink-0 flex">
              <StatusBadge status={application.status} />
            </div>
          </div>
          <div className="mt-2 sm:flex sm:justify-between">
            <div className="sm:flex">
              <p className="flex items-center text-sm text-gray-500">
                {application.job_listing.company.name}
              </p>
              {application.job_listing.remote && (
                <p className="mt-2 flex items-center text-sm text-gray-500 sm:mt-0 sm:ml-6">
                  <svg className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
                  </svg>
                  Remote
                </p>
              )}
            </div>
            <div className="mt-2 flex items-center text-sm text-gray-500 sm:mt-0">
              <svg className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clipRule="evenodd" />
              </svg>
              <span>
                {formatDate(application.applied_date)}
              </span>
            </div>
          </div>
        </div>
      </a>
    </li>
  );
};

const ApplicationsList = ({ applications = [] }) => {
  const [filteredApplications, setFilteredApplications] = useState([]);
  const [statusFilter, setStatusFilter] = useState('');
  const [sortBy, setSortBy] = useState('date');

  useEffect(() => {
    let filtered = statusFilter
      ? applications.filter(app => app.status === statusFilter)
      : applications;

    // Tri
    filtered = [...filtered].sort((a, b) => {
      switch (sortBy) {
        case 'date':
          return new Date(b.applied_date || 0) - new Date(a.applied_date || 0);
        case 'company':
          return a.job_listing.company.name.localeCompare(b.job_listing.company.name);
        case 'title':
          return a.job_listing.title.localeCompare(b.job_listing.title);
        case 'status':
          return a.status.localeCompare(b.status);
        default:
          return 0;
      }
    });

    setFilteredApplications(filtered);
  }, [applications, statusFilter, sortBy]);

  const statusOptions = [
    { value: '', label: 'Tous' },
    { value: 'applied', label: 'Postulé' },
    { value: 'interviewing', label: 'Entretien' },
    { value: 'offer', label: 'Offre' },
    { value: 'rejected', label: 'Refusé' },
    { value: 'accepted', label: 'Accepté' }
  ];

  const sortOptions = [
    { value: 'date', label: 'Date' },
    { value: 'company', label: 'Entreprise' },
    { value: 'title', label: 'Poste' },
    { value: 'status', label: 'Statut' }
  ];

  return (
    <div className="applications-list">
      <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-4 gap-4">
        <div className="flex flex-wrap gap-2">
          {statusOptions.map(option => (
            <button
              key={option.value}
              className={`px-3 py-1 text-sm rounded-full ${statusFilter === option.value ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'}`}
              onClick={() => setStatusFilter(option.value)}
            >
              {option.label}
            </button>
          ))}
        </div>

        <div className="flex items-center">
          <span className="text-sm text-gray-500 mr-2">Trier par:</span>
          <select
            className="block w-full pl-3 pr-10 py-1 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm rounded-md"
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value)}
          >
            {sortOptions.map(option => (
              <option key={option.value} value={option.value}>{option.label}</option>
            ))}
          </select>
        </div>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-md">
        {filteredApplications.length > 0 ? (
          <ul className="divide-y divide-gray-200">
            {filteredApplications.map(application => (
              <ApplicationCard key={application.id} application={application} />
            ))}
          </ul>
        ) : (
          <div className="px-4 py-5 text-center text-gray-500">
            Aucune candidature trouvée
          </div>
        )}
      </div>
    </div>
  );
};

export default ApplicationsList;
