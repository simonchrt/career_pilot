// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import React from 'react';
import { createRoot } from 'react-dom/client';

// Fonction pour monter les composants React
// Modifiez cette fonction dans app/javascript/application.js
window.mountReactComponent = (Component, elementId, props = {}) => {
  const element = document.getElementById(elementId);
  if (element) {
    const root = createRoot(element);
    root.render(React.createElement(Component, props));
    return root; // Retourner la racine pour pouvoir l'utiliser plus tard
  }
  return null;
};

// Importation des composants React
import Dashboard from './components/Dashboard';
import ApplicationsList from './components/ApplicationsList';

// Exposition globale des composants
window.ReactComponents = {
  Dashboard,
  ApplicationsList
};
