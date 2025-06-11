'use client';

import { useEffect, useState } from 'react';
import { usePathname } from 'next/navigation';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { MenuIcon, XIcon } from 'lucide-react';
import { useAuth } from '@/context/AuthContext';
import {
  FolderIcon,
  FilmIcon,
  BellIcon,
  MailIcon,
  InboxIcon,
} from 'lucide-react';

interface DashboardProps {
  children: React.ReactNode;
}

const navigation = [
  { name: 'Home', href: '/dashboard', icon: HomeIcon },
  { name: 'Categories', href: '/dashboard/categories', icon: FolderIcon },
  { name: 'Movies', href: '/dashboard/movies', icon: FilmIcon },
  { name: 'Comments', href: '/dashboard/comments', icon: InboxIcon },
  { name: 'Notifications', href: '/dashboard/notifications', icon: BellIcon },
  { name: 'Contact', href: '/dashboard/contact', icon: MailIcon },
  { name: 'Inquiries', href: '/dashboard/inquiries', icon: InboxIcon },
];

export function Dashboard({ children }: DashboardProps) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const pathname = usePathname();
  const { user, loading } = useAuth();
  const router = useRouter();

   useEffect(() => {
      if (!user && !loading) {
        router.push('/');
      }

  }, [user, loading, router]);

  if (!user && loading) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-100">
        <svg className="animate-spin h-10 w-10 text-gray-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
        </svg>
      </div>
    );
  }

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Mobile sidebar */}
      <div className="md:hidden">
        <div
          className={`fixed inset-0 z-40 bg-black bg-opacity-75 transition-opacity ${
            sidebarOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'
          }`}
          onClick={() => setSidebarOpen(false)}
        >
        </div>

        <div
          className={`fixed inset-y-0 left-0 z-50 w-64 bg-gray-800 transition-transform duration-300 ease-in-out ${
            sidebarOpen ? 'translate-x-0' : '-translate-x-full'
          }`}
        >
          <div className="flex items-center justify-between px-4 py-5 border-b border-gray-700">
            <h1 className="text-xl font-bold text-white">Dashboard</h1>
            <button
              onClick={() => setSidebarOpen(false)}
              className="text-gray-400 hover:text-white"
            >
              <XIcon className="h-6 w-6" />
            </button>
          </div>
          <nav className="px-2 py-4">
            {navigation.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className={`flex items-center px-3 py-2 text-sm font-medium rounded-md ${
                  pathname === item.href
                    ? 'bg-gray-900 text-white'
                    : 'text-gray-300 hover:bg-gray-700 hover:text-white'
                }`}
                onClick={() => setSidebarOpen(false)}
              >
                <item.icon className="h-5 w-5 mr-3" />
                {item.name}
              </Link>
            ))}
          </nav>
        </div>
      </div>

      {/* Desktop sidebar */}
      <div className="hidden md:flex md:flex-shrink-0">
        <div className="flex flex-col w-64 bg-gray-800">
          <div className="flex items-center h-16 px-4 bg-gray-900">
            <h1 className="text-xl font-bold text-white">Dashboard</h1>
          </div>
          <nav className="flex-1 px-2 py-4 space-y-1 overflow-y-auto">
            {navigation.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className={`flex items-center px-3 py-2 text-sm font-medium rounded-md ${
                  pathname === item.href
                    ? 'bg-gray-900 text-white'
                    : 'text-gray-300 hover:bg-gray-700 hover:text-white'
                }`}
              >
                <item.icon className="h-5 w-5 mr-3" />
                {item.name}
              </Link>
            ))}
          </nav>
        </div>
      </div>

      {/* Main content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Mobile top header */}
        <header className="md:hidden bg-white shadow">
          <div className="flex items-center justify-between px-4 py-3">
            <button
              onClick={() => setSidebarOpen(true)}
              className="text-gray-500 hover:text-gray-600"
            >
              <MenuIcon className="h-6 w-6" />
            </button>
            <h2 className="text-lg font-medium text-gray-800">
              {navigation.find((item) => item.href === pathname)?.name}
            </h2>
            <div className="w-6"></div> {/* Spacer for alignment */}
          </div>
        </header>

        {/* Main content area */}
            <div className="w-full flex-1 overflow-auto p-4 md:p-8 lg:ml-0 ml-0 md:ml-64">
          {children}
          </div>
      </div>
    </div>
  );
}

// Mock icons - replace with actual imports from your icon library
function HomeIcon(props: React.SVGProps<SVGSVGElement>) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="currentColor"
    >
      <path d="M11.47 3.84a.75.75 0 011.06 0l8.69 8.69a.75.75 0 101.06-1.06l-8.689-8.69a2.25 2.25 0 00-3.182 0l-8.69 8.69a.75.75 0 001.061 1.06l8.69-8.69z" />
      <path d="M12 5.432l8.159 8.159c.03.03.06.058.091.086v6.198c0 1.035-.84 1.875-1.875 1.875H15a.75.75 0 01-.75-.75v-4.5a.75.75 0 00-.75-.75h-3a.75.75 0 00-.75.75V21a.75.75 0 01-.75.75H5.625a1.875 1.875 0 01-1.875-1.875v-6.198a2.29 2.29 0 00.091-.086L12 5.43z" />
    </svg>
  );
}

// Add similar mock components for other icons (FolderIcon, FilmIcon, etc.)