import { chromium } from 'playwright';
import path from 'node:path';

const OUT = path.resolve('public/assets/images');
const browser = await chromium.launch();

async function shotLogin(url, outFile) {
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  page.setDefaultTimeout(90000);
  await page.goto(url, { waitUntil: 'domcontentloaded' });
  await page.waitForSelector('input[type="email"], input[type="text"]', { timeout: 60000 }).catch(() => {});
  await page.waitForTimeout(1500);
  await page.screenshot({ path: path.join(OUT, outFile) });
  console.log('saved', outFile);
  return page;
}

async function loginAndShot(page, emailSel, email, passSel, password, submitSel, outFile) {
  await page.fill(emailSel, email);
  await page.fill(passSel, password);
  await page.click(submitSel);
  await page.waitForLoadState('networkidle', { timeout: 30000 }).catch(() => {});
  await page.waitForTimeout(4000);
  await page.screenshot({ path: path.join(OUT, outFile) });
  console.log('saved', outFile, 'at', page.url());
}

try {
  console.log('=== IT Assist ===');
  const page = await shotLogin('https://it-assist-api.onrender.com/panel/login', 'itassist_welcome.png');
  await loginAndShot(
    page,
    'input[type="email"]', 'it@company.com',
    'input[type="password"]', 'password',
    'button:has-text("Sign in")',
    'itassist_home.png'
  );
  await page.close();
} catch (e) {
  console.error('itassist error', e.message);
}

await browser.close();
