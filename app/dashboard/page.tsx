import { Dashboard } from "@/components/Dashboard";

// app/page.tsx
export default function Home() {
  return (
    <Dashboard>
    <div>
      <h1 className="text-2xl md:text-3xl font-bold mb-4 md:mb-6">Welcome to Dashboard</h1>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
        {/* Stats Cards */}
        <DashboardCard title="Total Movies" value="1,234" trend="up" />
        <DashboardCard title="Categories" value="24" trend="neutral" />
        <DashboardCard title="New Notifications" value="5" trend="down" />
      </div>
      
      <div className="mt-6 md:mt-8">
        <h2 className="text-xl font-semibold mb-3 md:mb-4">Recent Activity</h2>
        <div className="bg-white rounded-lg shadow p-4 overflow-x-auto">
          <ResponsiveTable />
        </div>
      </div>
    </div>
    </Dashboard>
  );
}

function DashboardCard({ 
  title, 
  value,
  trend 
}: { 
  title: string; 
  value: string;
  trend: "up" | "down" | "neutral";
}) {
  const trendColors = {
    up: "text-green-500",
    down: "text-red-500",
    neutral: "text-gray-500"
  };

  const trendIcons = {
    up: "↑",
    down: "↓",
    neutral: "→"
  };

  return (
    <div className="bg-white rounded-lg shadow p-4 md:p-6">
      <h3 className="text-gray-500 text-sm font-medium">{title}</h3>
      <div className="flex items-center justify-between">
        <p className="text-xl md:text-2xl font-bold">{value}</p>
        <span className={`${trendColors[trend]} text-lg`}>
          {trendIcons[trend]}
        </span>
      </div>
    </div>
  );
}

function ResponsiveTable() {
  return (
    <table className="min-w-full divide-y divide-gray-200">
      <thead className="bg-gray-50">
        <tr>
          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Event</th>
          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider hidden sm:table-cell">User</th>
          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Time</th>
        </tr>
      </thead>
      <tbody className="bg-white divide-y divide-gray-200">
        <TableRow 
          event="Movie added" 
          user="admin" 
          time="2 minutes ago" 
        />
        <TableRow 
          event="Category updated" 
          user="editor" 
          time="15 minutes ago" 
        />
        <TableRow 
          event="New inquiry" 
          user="guest" 
          time="1 hour ago" 
        />
      </tbody>
    </table>
  );
}

function TableRow({ event, user, time }: { event: string; user: string; time: string }) {
  return (
    <tr>
      <td className="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">{event}</td>
      <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500 hidden sm:table-cell">{user}</td>
      <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500">{time}</td>
    </tr>
  );
}