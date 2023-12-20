'use client'
import './globals.css'
import { Inter } from 'next/font/google'
import { useState } from 'react'
import Head from 'next/head'
import { Icon } from '@iconify/react'

const inter = Inter({ subsets: ['latin'] })

export default function RootLayout ({
  children
}: {
  children: React.ReactNode
}) {
  const [isOpen, setIsOpen] = useState(false)

  const handleToggle = () => {
    setIsOpen(!isOpen)
  }

  const handleClose = () => {
    setIsOpen(false)
  }

  return (
    <html lang='en'>
      <Head>
        <title>Pipline Orchestration</title>
      </Head>
      <body className={inter.className}>
        <nav className='p-6'>
          <div className='flex items-center justify-between flex-wrap'>
            <button onClick={handleToggle} className='lg:hidden'>
              <Icon icon='ooui:menu' />
            </button>
            <div
              className={`${
                isOpen ? 'block' : 'hidden'
              } w-full block flex-grow lg:flex lg:items-center lg:w-auto`}
            >
              <div className='text-sm lg:flex-grow'>
                <a
                  href='#docker-setup'
                  className='block mt-4 lg:inline-block lg:mt-0  mr-4'
                  onClick={handleClose}
                >
                  Docker Setup
                </a>
                <a
                  href='#airbyte-setup'
                  className='block mt-4 lg:inline-block lg:mt-0  mr-4'
                  onClick={handleClose}
                >
                  Airbyte Setup
                </a>
                <a
                  href='#terraform-provisioning'
                  className='block mt-4 lg:inline-block lg:mt-0  mr-4'
                  onClick={handleClose}
                >
                  Terraform Provisioning
                </a>
                <a
                  href='#dbt-models'
                  className='block mt-4 lg:inline-block lg:mt-0  mr-4'
                  onClick={handleClose}
                >
                  DBT Models
                </a>
                <a
                  href='#dagster-orchestration'
                  className='block mt-4 lg:inline-block lg:mt-0 mr-4'
                  onClick={handleClose}
                >
                  Dagster Orchestration
                </a>
                <a
                  href='#tableau'
                  className='block mt-4 lg:inline-block lg:mt-0 mr-4'
                  onClick={handleClose}
                >
                  Tableau
                </a>
              </div>
            </div>
          </div>
        </nav>
        <main className='p-4 flex-grow '>{children}</main>
      </body>
    </html>
  )
}
