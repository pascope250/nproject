// components/sidebar.tsx
'use client';

import { useState } from 'react';
import { MenuIcon, XIcon } from 'lucide-react';
import Link from 'next/link';

export default function Sidebar() {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <>
      {/* Mobile sidebar toggle */}
      <button
        className="md:hidden fixed top-4 left-4 z-50 p-2 rounded-md bg-gray-800 text-white"
        onClick={() => setSidebarOpen(!sidebarOpen)}
      >
        {sidebarOpen ? <XIcon size={24} /> : <MenuIcon size={24} />}
      </button>

      {/* Sidebar - Hidden on mobile by default */}
      <div
        className={`w-64 bg-gray-800 text-white p-4 fixed md:static inset-y-0 left-0 z-40 transform ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'
        } transition-transform duration-200 ease-in-out`}
      >
        <div className="text-xl font-bold mb-8 pt-4 md:pt-0">Dashboard</div>
        <nav>
          <ul className="space-y-2">
            <NavItem href="/" onClick={() => setSidebarOpen(false)}>Home</NavItem>
            <NavItem href="/categories" onClick={() => setSidebarOpen(false)}>Categories</NavItem>
            <NavItem href="/movies" onClick={() => setSidebarOpen(false)}>Movies</NavItem>
            <NavItem href="/notifications" onClick={() => setSidebarOpen(false)}>Notifications</NavItem>
            <NavItem href="/contact" onClick={() => setSidebarOpen(false)}>Contact</NavItem>
            <NavItem href="/inquiries" onClick={() => setSidebarOpen(false)}>Inquiries</NavItem>
          </ul>
        </nav>
      </div>
    </>
  );
}

function NavItem({ 
  href, 
  children,
  onClick 
}: { 
  href: string; 
  children: React.ReactNode;
  onClick?: () => void;
}) {
  return (
    <li>
      <Link
        href={href}
        className="block px-4 py-2 rounded hover:bg-gray-700 transition-colors"
        onClick={onClick}
      >
        {children}
      </Link>
    </li>
  );
}