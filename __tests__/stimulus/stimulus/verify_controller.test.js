import { waitFor } from '@testing-library/dom';
import { getHTML, setHTML, startStimulus } from '../_stimulus_helper';
import VerifyController from '../../../app/javascript/controllers/verify_controller';

beforeEach(() => startStimulus('verify', VerifyController));

test('it focuses on the next input field when a character is entered', async () => {
  await setHTML(`
    <form data-controller="verify">
      <input id="1" type="text" data-verify-target="codeInput">
      <input id="2" type="text" data-verify-target="codeInput">
      <input id="3" type="text" data-verify-target="codeInput">
      <button type="submit">Submit</button>
    </form>
  `);

  const input1 = document.getElementById('1')
  const input2 = document.getElementById('2')
  const input3 = document.getElementById('3')


  input1.value = '1';
  input1.dispatchEvent(new Event('input'));

  await waitFor(() => {
    expect(document.activeElement).toBe(input2);
  });

  input2.value = '2';
  input2.dispatchEvent(new Event('input'));

  await waitFor(() => {
    expect(document.activeElement).toBe(input3);
  });

  expect(getHTML()).toMatchSnapshot();
});
