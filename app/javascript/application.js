// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import React from 'react';
import { createRoot } from 'react-dom/client';
import './controllers';

// Fonction pour monter les composants React
window.mountReactComponent = (Component, elementId, props = {}) => {
  const element = document.getElementById(elementId);
  if (element) {
    const root = createRoot(element);
    root.render(<Component {...props} />);
  }
};

// Importation des composants React
import Dashboard from './components/Dashboard';
import ApplicationsList from './components/ApplicationsList';
import JobListingForm from './components/JobListingForm';

// Exposition globale des composants
window.ReactComponents = {
  Dashboard,
  ApplicationsList,
  JobListingForm
};
