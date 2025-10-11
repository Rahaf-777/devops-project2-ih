import React from 'react';
import './BurgerBuilder.css';

interface IngredientCardProps {
  name: string;
  image: string;
  price: number;
  onAdd: () => void;
}

const IngredientCard: React.FC<IngredientCardProps> = ({ name, image, price, onAdd }) => {
  return (
    <div className="ingredient-card">
      <img src={image} alt={name} className="ingredient-image" />
      <h4>{name}</h4>
      <p className="price">${price.toFixed(2)}</p>
      <button className="add-btn" onClick={onAdd}>
        Add +
      </button>
    </div>
  );
};

export default IngredientCard;
