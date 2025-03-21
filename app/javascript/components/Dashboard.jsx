import React, { useEffect, useState } from 'react';

const Dashboard = (props) => {
  const [stats, setStats] = useState({
    totalApplications: 0,
    pendingApplications: 0,
    acceptedApplications: 0,
    rejectedApplications: 0
  });

  useEffect(() => {
    setStats({
      totalApplications: props.totalApplications || 0,
      pendingApplications: props.pendingApplications || 0,
      acceptedApplications: props.acceptedApplications || 0,
      rejectedApplications: props.rejectedApplications || 0
    });
  }, [props]);

  return (
    <div className="dashboard-stats grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
      <div className="bg-white rounded-lg shadow p-6 text-center">
        <p className="text-3xl font-bold text-blue-600">{stats.totalApplications}</p>
        <p className="text-sm text-gray-500">Total</p>
      </div>
      <div className="bg-white rounded-lg shadow p-6 text-center">
        <p className="text-3xl font-bold text-yellow-600">{stats.pendingApplications}</p>
        <p className="text-sm text-gray-500">En cours</p>
      </div>
      <div className="bg-white rounded-lg shadow p-6 text-center">
        <p className="text-3xl font-bold text-green-600">{stats.acceptedApplications}</p>
        <p className="text-sm text-gray-500">Acceptées</p>
      </div>
      <div className="bg-white rounded-lg shadow p-6 text-center">
        <p className="text-3xl font-bold text-red-600">{stats.rejectedApplications}</p>
        <p className="text-sm text-gray-500">Refusées</p>
      </div>
    </div>
  );
};

export default Dashboard;
