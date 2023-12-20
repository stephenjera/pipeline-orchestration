import Image from 'next/image';

type AnimatedCardProps = {
  title: string;
  description: string;
  imageSrc?: string; // Make imageSrc optional
};

const AnimatedCard: React.FC<AnimatedCardProps> = ({ title, description, imageSrc }) => (
  <div className="p-4 transition duration-300 transform hover:scale-105">
    <h2 className="text-2xl font-bold">{title}</h2>
    <p className="mt-2 text-lg">{description}</p>
    {imageSrc && (
      <div className="mt-4">
        <Image src={imageSrc} alt={`${title} Image`} width={500} height={300} />
      </div>
    )}
  </div>
);

export default AnimatedCard;
