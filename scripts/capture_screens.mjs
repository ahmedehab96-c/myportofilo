import { chromium } from 'playwright';
import path from 'node:path';

const OUT = path.resolve('public/assets/images');

async function shot(page, url, waitSelector, outFile, { login } = {}) {
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 90000 });
  if (waitSelector) await page.waitForSelector(waitSelector, { timeout: 60000 });
  await page.waitForTimeout(1500);
  await page.screenshot({ path: path.join(OUT, outFile) });
  console.log('saved', outFile);
  if (login) {
    const startUrl = page.url();
    await page.fill(login.emailSel, login.email);
    await page.fill(login.passSel, login.password);
    await page.click(login.submitSel);
    try {
      await page.waitForFunction(
        (start) => location.href !== start,
        startUrl,
        { timeout: 90000 }
      );
    } catch {}
    await page.waitForLoadState('networkidle', { timeout: 30000 }).catch(() => {});
    await page.waitForTimeout(6000);
    await page.screenshot({ path: path.join(OUT, login.outFile) });
    console.log('saved', login.outFile, 'at', page.url());
  }
}

const browser = await chromium.launch();
const context = await browser.newContext({ viewport: { width: 1440, height: 900 } });
const page = await context.newPage();
page.setDefaultTimeout(60000);

try {
  console.log('=== Premium Gym ===');
  await shot(
    page,
    'https://ahmedmyportofilo.netlify.app/demos/premiumgym/admin/login',
    'input[type="email"], input[name="email"]',
    'premiumgym_welcome.png',
    {
      login: {
        email: 'ahmed.ehab@premiumgym.com',
        password: 'password',
        emailSel: 'input[type="email"], input[name="email"]',
        passSel: 'input[type="password"], input[name="password"]',
        submitSel: 'button[type="submit"]',
        afterSel: 'body',
        outFile: 'premiumgym_home.png',
      },
    }
  );
} catch (e) {
  console.error('gym error', e.message);
}

try {
  console.log('=== Property Asset Management ===');
  await shot(
    page,
    'https://property-asset-mgmt-api.onrender.com/dashboard/',
    'input[type="email"], input[name="email"]',
    'propertymgmt_welcome.png',
    {
      login: {
        email: 'admin@demo.com',
        password: 'password',
        emailSel: 'input[type="email"], input[name="email"]',
        passSel: 'input[type="password"], input[name="password"]',
        submitSel: 'button[type="submit"]',
        afterSel: 'body',
        outFile: 'propertymgmt_home.png',
      },
    }
  );
} catch (e) {
  console.error('property error', e.message);
}

await browser.close();
