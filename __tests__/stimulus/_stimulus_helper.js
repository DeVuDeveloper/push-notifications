import { Application } from '@hotwired/stimulus';

export function startStimulus(name, controller) {
  const application = Application.start();
  application.register(name, controller);
}

export async function setHTML(content = '') {
  document.body.innerHTML = content.trim();
  return document.body.innerHTML;
}

export function getHTML() {
  return document.body.innerHTML.trim();
}