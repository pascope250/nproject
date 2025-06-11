import type { Metadata } from "next";
import { Geist_Mono } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/context/AuthContext";
import { CategoryProvider } from "@/context/CategoryContext";
import { MovieProvider } from "@/context/MovieContext";
import { SourceProvider } from "@/context/SourceContext";
import { CommentProvider } from "@/context/commentContext";
import { NotificationProvider } from "@/context/NotificationContext";
import { ContactProvider } from "@/context/ContactContext";
import { InquiryProvider } from "@/context/InquiryContext";
const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Dashboard",
  description: "Dashboard for manage all data",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${geistMono.variable} antialiased bg-gray-100`}>
        <div className="flex h-screen">
          <div className="flex-1 overflow-auto lg:ml-0 ml-0 md:ml-64">
            <AuthProvider>
              <CommentProvider>
                <SourceProvider>
                  <ContactProvider>
                    <InquiryProvider>
                      <NotificationProvider>
                        <MovieProvider>
                          <CategoryProvider>{children}</CategoryProvider>
                        </MovieProvider>
                      </NotificationProvider>
                    </InquiryProvider>
                  </ContactProvider>
                </SourceProvider>
              </CommentProvider>
            </AuthProvider>
          </div>
        </div>
      </body>
    </html>
  );
}
