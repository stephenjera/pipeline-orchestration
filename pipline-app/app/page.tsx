import Tableau from '@/components/Tableau'
import AnimatedCard from '@/components/AnimatedCard'
import Image from 'next/image'

const dagsterImg = '/assets/dagster-orchestration.png'
// Update airbyteContent
const airbyteContent = {
  title: 'Airbyte Setup',
  description:
    'Airbyte, our virtuoso data conductor, gracefully extracts and loads data from various sources into our pipeline. Picture it orchestrating a symphony of data, bringing diverse elements together in harmony.'
}

// Update dagsterContent
const dagsterContent = {
  title: 'Dagster Orchestration',
  description:
    'Dagster, our maestro, orchestrates the entire pipeline with seamless precision. Picture it conducting a grand symphony of data operations, ensuring each note is played with perfection.'
}

// Update dbtContent
const dbtContent = {
  title: 'DBT Models',
  description:
    'DBT, our maestros, crafts intricate data models that dance with precision and elegance. Picture them as the choreographers, creating a masterpiece that tells the story of our data in a captivating performance.'
}

// Update dockerContent
const dockerContent = {
  title: 'Docker Setup',
  description:
    'Docker, our backstage crew, sets up the database for our pipeline. Picture it as the stagehands, working behind the scenes to create the foundation for the spectacular show that is our data processing.'
}

// Update terraformContent
const terraformContent = {
  title: 'Terraform Provisioning',
  description:
    "Terraform, our orchestrator of infrastructure, provisions the stage for our pipeline's performance. Picture it as the architect, designing and building the set where our data symphony unfolds."
}

// Update tableauContent
const tableauContent = {
  title: 'Tableau Dashboard',
  description:
    'Tableau, our visual storyteller, crafts a stunning dashboard for our pipeline. Picture it as the artist, painting a vivid picture that brings the entire performance to life, allowing us to see and understand the beauty of our data symphony.'
}

export default function Home () {
  return (
    <div className='p-4'>
      <h1 className='text-3xl font-bold mb-4 text-center'>
        Welcome to My Pipeline
      </h1>

      {/* Pipeline Image */}
      <div className='mb-8 pulse'>
        <Image
          src={dagsterImg}
          alt='Pipeline Overview'
          className='mx-auto'
          width={1000}
          height={1000}
          style={{ opacity: 0.8 }} // Adjust the opacity value as needed (0 to 1)
        />
      </div>

      {/* Card Grid */}
      <div className='grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-8'>
        <section id='docker-setup'>
          <AnimatedCard {...dockerContent} />
        </section>

        <section id='airbyte-setup'>
          <AnimatedCard {...airbyteContent} />
        </section>

        <section id='terraform-provisioning'>
          <AnimatedCard {...terraformContent} />
        </section>

        <section id='dbt-models'>
          <AnimatedCard {...dbtContent} />
        </section>

        <section id='dagster-orchestration'>
          <AnimatedCard {...dagsterContent} />
        </section>
        
        <section id='tableau'>
          <AnimatedCard {...tableauContent} />
        </section>
      </div>

      {/* Tableau Dashboard */}
      <Tableau />
    </div>
  )
}
