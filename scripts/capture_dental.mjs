import { chromium } from 'playwright';
import path from 'node:path';

const OUT = path.resolve('public/assets/images');
const BASE = 'http://localhost:5199/demos/dental-clinic';

const browser = await chromium.launch();

async function loginAs(email, password, outFile, dashPath) {
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  page.setDefaultTimeout(60000);
  await page.goto(`${BASE}/`, { waitUntil: 'domcontentloaded' });
  await page.click('a[href*="/login"]');
  await page.waitForSelector('input[type="email"]', { timeout: 30000 });
  await page.fill('input[type="email"]', email);
  await page.fill('input[type="password"]', password);
  await page.click('button[type="submit"]');
  await page.waitForURL(`**${dashPath}**`, { timeout: 30000 }).catch(() => {});
  await page.waitForLoadState('networkidle', { timeout: 15000 }).catch(() => {});
  await page.waitForTimeout(2500);
  await page.screenshot({ path: path.join(OUT, outFile) });
  console.log('saved', outFile, 'at', page.url());
  await page.close();
}

try {
  const home = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  await home.goto(`${BASE}/`, { waitUntil: 'networkidle', timeout: 30000 });
  await home.waitForTimeout(1500);
  await home.screenshot({ path: path.join(OUT, 'dentalclinic_website.png') });
  console.log('saved dentalclinic_website.png, title:', await home.title());
  await home.close();
} catch (e) {
  console.error('home error', e.message);
}

try {
  await loginAs('admin@radiantdental.care', 'password', 'dentalclinic_admin.png', '/admin');
} catch (e) {
  console.error('admin error', e.message);
}

try {
  await loginAs('doctor@radiantdental.care', 'password', 'dentalclinic_doctor.png', '/doctor');
} catch (e) {
  console.error('doctor error', e.message);
}

try {
  await loginAs('patient@example.com', 'password', 'dentalclinic_patient.png', '/dashboard');
} catch (e) {
  console.error('patient error', e.message);
}

await browser.close();
