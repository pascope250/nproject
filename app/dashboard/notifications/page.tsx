'use client';

import { Dashboard } from '@/components/Dashboard';
import { Notification } from '@/types/notification';
import { FormEvent, useState } from 'react';
import { useNotifications } from '@/context/NotificationContext';


export default function NotificationPage() {
  const [formData, setFormData] = useState({
    title: '',
    url: '',
    message:''
  });
  const { notifications, sendNotification,loading, clearAllNotifications} = useNotifications();
  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    try{
      await sendNotification(formData.title,formData.message,formData.url);
      setFormData({
        title: '',
        url: '',
        message:''
      });
    }catch(err){
      console.log(err);
    }
  };

  const markAsRead = async (id: number) => {
    
  };

  const clearAll = async () => {
   await clearAllNotifications();
  };

  return (
    <Dashboard>
    <div className="max-w-2xl mx-auto mt-10">
      {/* Send Notification Form */}
      <div className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-6">
        <h2 className="text-xl font-bold mb-4 text-gray-800">Send Notification</h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="title">
              Title
            </label>
            <input
              id="title"
              name="title"
              type="text"
              required
              value={formData.title}
              onChange={(e) => setFormData({...formData, title: e.target.value})}
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              placeholder="Notification title"
            />
          </div>
          <div>
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="url">
              URL
            </label>
            <input
              id="url"
              name="url"
              type="text"
              required
              value={formData.url}
              onChange={(e) => setFormData({...formData, url: e.target.value})}
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              placeholder="Redirect URL"
            />
          </div>
          <div>
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="message">
              Message
            </label>
            <textarea
              id="message"
              name="message"
              rows={3}
              required
              value={formData.message}
              onChange={(e) => setFormData(
                {...formData, message: e.target.value}
              )}

              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              placeholder="Notification message"
            />
          </div>
          <div className="text-right">
            <button
              type="submit"
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
            >
              Send Notification
            </button>
          </div>
        </form>
      </div>

      {/* Notifications List */}
      <div className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-6">
        <h2 className="text-2xl font-bold mb-4 text-gray-800">Notifications</h2>
        <div>
          {notifications.length > 0 ? (
            <>
              <ul>
                {notifications.map((notification) => (
                  <li
                    key={notification.id}
                    className={`mb-4 border-b pb-3 flex items-start ${
                      !notification.is_read ? 'bg-blue-50' : ''
                    }`}
                  >
                    <div className="flex-1">
                      <div className="flex items-center justify-between">
                        <span className="font-semibold text-gray-900">{notification.title}</span>
                        <span className="text-xs text-gray-400">{notification.created_at}</span>
                      </div>
                      <p className="text-gray-700 mt-1">{notification.message}</p>
                    </div>
                    {!notification.is_read && (
                      <button
                        onClick={() => markAsRead(notification.id)}
                        className="ml-4 text-xs text-blue-600 hover:underline"
                      >
                        Mark as read
                      </button>
                    )}
                  </li>
                ))}
              </ul>
              <div className="mt-6 text-right">
                <button
                  onClick={clearAll}
                  className="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded text-sm font-semibold disabled:cursor-not-allowed"
                  disabled={loading}
                >
                  {
                    loading ? 'Clearing...' : 'Clear All Notifications'
                  }
                  
                </button>
              </div>
            </>
          ) : (
            <p className="text-gray-500">No notifications yet.</p>
          )}
        </div>
      </div>
    </div>
    </Dashboard>
  );
}