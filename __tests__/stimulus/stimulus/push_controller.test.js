import { setHTML, startStimulus } from "../_stimulus_helper";
import PushController from "../../../app/javascript/controllers/push_controller";

beforeEach(() => startStimulus("push-notification", PushController));
const bodyElement = document.querySelector('body');
const applicationServerKeyValue = bodyElement.getAttribute('data-application-server-key');
test("it registers and saves a push subscription when permission is granted", async () => {
  await setHTML(`
    <div data-controller="push" data-application-server-key="${applicationServerKeyValue}">
      <button data-action="click->push#connect">Connect</button>
    </div>
  `);

  const connectButton = document.querySelector(
    '[data-action="click->push#connect"]'
  );

  connectButton.click();
});
