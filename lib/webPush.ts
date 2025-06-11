import webpush from 'web-push';

// Initialize web push with VAPID keys
export function initializeWebPush() {
  if (!process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY || !process.env.VAPID_PRIVATE_KEY || !process.env.NOTIFICATION_EMAIL) {
    throw new Error('Missing VAPID keys or notification email in environment variables');
  }

  webpush.setVapidDetails(
    `mailto:${process.env.NOTIFICATION_EMAIL}`,
    process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY,
    process.env.VAPID_PRIVATE_KEY
  );
}

// Send a push notification to a specific subscription
export async function sendPushNotification(
  subscription: { endpoint: string; p256dh_key: string; auth_key: string },
  payload: any
) {
  try {
    await webpush.sendNotification(
      {
        endpoint: subscription.endpoint,
        keys: {
          p256dh: subscription.p256dh_key,
          auth: subscription.auth_key,
        },
      },
      JSON.stringify(payload)
    );
  } catch (error) {
    console.error('Error sending push notification:', error);
    
    // Check if the subscription is invalid/expired
    if (
      typeof error === 'object' &&
      error !== null &&
      'statusCode' in error &&
      (error as any).statusCode === 410 || (error as any).statusCode === 404
    ) {
      // This would be a good place to remove expired subscriptions from your database
      console.log('Subscription has expired or is no longer valid');
      throw new Error('ExpiredSubscription');
    }
    
    throw error;
  }
}

// Utility to generate VAPID keys (you can run this once and store the keys in your env)
// export function generateVapidKeys() {
//   const vapidKeys = webpush.generateVAPIDKeys();
//   console.log('VAPID Keys generated:');
//   console.log('Public Key:', vapidKeys.publicKey);
//   console.log('Private Key:', vapidKeys.privateKey);
//   return vapidKeys;
// }

// Note: You can run generateVapidKeys() once to get your keys
// Then store them in your environment variables:
// NEXT_PUBLIC_VAPID_PUBLIC_KEY=your_public_key
// VAPID_PRIVATE_KEY=your_private_key
// NOTIFICATION_EMAIL=your_email@example.com