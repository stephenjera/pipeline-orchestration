'use client'
import { useEffect } from 'react'

type TableauVizProps = {
    id: string;
    src: string;
    device?: string;
    toolbar?: string;  
}

declare global {
  namespace JSX {
    interface IntrinsicElements {
      'tableau-viz': React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement> & TableauVizProps
    }
  }
}

export default function Tableau () {
  useEffect(() => {
    const script = document.createElement('script')
    script.src =
      'https://public.tableau.com/javascripts/api/tableau.embedding.3.latest.min.js'
    script.type = 'module'
    document.body.appendChild(script)
  }, [])

  let smallScreen

  if (typeof window !== 'undefined') {
    smallScreen = window.matchMedia('(max-width: 1000px)')
  }
  if (smallScreen && smallScreen.matches) {
    return (
      <tableau-viz
        id='tableauViz'
        src='https://public.tableau.com/views/GlobalSuperstore_17028504821260/Sales'
        device='phone'
        toolbar='bottom'
      ></tableau-viz>
    )
  } else {
    return (
      <tableau-viz
        id='tableauViz'
        src='https://public.tableau.com/views/GlobalSuperstore_17028504821260/Sales'
        toolbar='bottom'
      ></tableau-viz>
    )
  }
}
