%Jake Krishnamurti

:- use_module(library(lists)).
:- style_check(-singleton). %Silence the singleton variable warning caused by the last predicate

%Person data item
person(person(Nationality, HouseColour, HousePosition, Beverage, Cigar, Pet),
	Nationality, HouseColour, HousePosition, Beverage, Cigar, Pet).

%Field accessors/setters
person_Nationality(person(Nationality, _HouseColour, _HousePosition, _Beverage, _Cigar, _Pet), Nationality).
person_HouseColour(person(_Nationality, HouseColour, _HousePosition, _Beverage, _Cigar, _Pet), HouseColour).
person_HousePosition(person(_Nationality, _HouseColour, HousePosition, _Beverage, _Cigar, _Pet), HousePosition).
person_Beverage(person(_Nationality, _HouseColour, _HousePosition, Beverage, _Cigar, _Pet), Beverage).
person_Cigar(person(_Nationality, _HouseColour, _HousePosition, _Beverage, Cigar, _Pet), Cigar).
person_Pet(person(_Nationality, _HouseColour, _HousePosition, _Beverage, _Cigar, Pet), Pet).


%Domains for the fields
nationalities([brit, swede, dane, norwegian, german]).
houseColours([red, green, white, yellow, blue]).
housePositions([1, 2, 3, 4, 5]).
beverages([tea, coffee, milk, beer, water]).
cigars([pallMall, dunhill, blend, blueMaster, prince]).
pets([dogs, birds, cats, horses, fish]).


%Encoding of clues
solution(Persons) :-
    
    Persons = [Brit, Swede, Dane, Norwegian, German],
    
    person(Brit, brit,
	    BritHouseColour, BritHousePosition, BritBeverage, BritCigar, BritPet),
    person(Swede, swede,
	    SwedeHouseColour, SwedeHousePosition, SwedeBeverage, SwedeCigar, SwedePet), 
    person(Dane, dane,
	    DaneHouseColour, DaneHousePosition, DaneBeverage, DaneCigar, DanePet), 
    person(Norwegian, norwegian,
	    NorwegianHouseColour, NorwegianHousePosition, NorwegianBeverage, NorwegianCigar, NorwegianPet),  
    person(German, german,
	    GermanHouseColour, GermanHousePosition, GermanBeverage, GermanCigar, GermanPet), 
    houseColours(HouseColours),
    housePositions(HousePositions),
    beverages(Beverages),
    cigars(Cigars),
    pets(Pets),
    
    %the Brit lives in the red house
    person_Nationality(Brit, brit),
    member(Brit, Persons),
    person_HouseColour(Brit, red),
    
    %the Swede keeps dogs as pets
    person_Nationality(Swede, swede),
    member(Swede, Persons),
    person_Pet(Swede, dogs),
    
    %the Dane drinks tea
    person_Nationality(Dane, dane),
    member(Dane, Persons),
    person_Beverage(Dane, tea),
    
    %the green house is on the left of the white house
    person_HouseColour(Green, green),
    member(Green, Persons),
    person_HousePosition(Green, GreenPosition),
    member(GreenPosition, HousePositions),
    
    person_HouseColour(White, white),
    member(White, Persons),
    person_HousePosition(White, WhitePosition),
    member(WhitePosition, HousePositions),
    
    GreenPosition is WhitePosition - 1,
    
    %the green house’s owner drinks coffee
    person_Beverage(Green, coffee),
    
    %the person who smokes Pall Mall rears birds
    person_Cigar(PallMall, pallMall),
    member(PallMall, Persons),
    person_Pet(PallMall, birds),
    
    %the owner of the yellow house smokes Dunhill
    person_HouseColour(Yellow, yellow),
    member(Yellow, Persons),
    person_Cigar(Yellow, dunhill),
    
    %the man living in the center house drinks milk
    person_Beverage(Milk, milk),
    member(Milk, Persons),
    person_HousePosition(Milk, 3),
    
    %the Norwegian lives in the first house
    person_Nationality(Norwegian, norwegian),
    member(Norwegian, Persons),
    person_HousePosition(Norwegian, NorwegianPosition),
    NorwegianPosition is 1,
    
    %the man who smokes blends lives next to the one who keeps cats
    person_Cigar(Blend, blend),
    member(Blend, Persons),
    person_HousePosition(Blend, BlendPosition),
    member(BlendPosition, HousePositions),
    
    person_Pet(Cats, cats),
    member(Cats, Persons),
    person_HousePosition(Cats, CatsPosition),
    member(CatsPosition, HousePositions),
    
    (   BlendPosition is CatsPosition - 1; BlendPosition is CatsPosition + 1),
    
    
    %the man who keeps horses lives next to the man who smokes Dunhill
    person_Pet(Horses, horses),
    member(Horses, Persons),
    person_HousePosition(Horses, HorsesPosition),
    member(HorsesPosition, HousePositions),
    
    person_Cigar(Dunhill, dunhill),
    member(Dunhill, Persons),
    person_HousePosition(Dunhill, DunhillPosition),
    member(DunhillPosition, HousePositions),
    
    (   HorsesPosition is DunhillPosition - 1; HorsesPosition is DunhillPosition + 1),
    
    %the owner who smokes BlueMaster drinks beer
    person_Cigar(BlueMaster, blueMaster),
    member(BlueMaster, Persons),
    person_Beverage(BlueMaster, beer),
    
    
    %the German smokes Prince
    person_Nationality(German, german),
    member(German, Persons),
    person_Cigar(German, prince),
    
    
    %the Norwegian lives next to the blue house
    person_HouseColour(Blue, blue),
    member(Blue, Persons),
    person_HousePosition(Blue, BluePosition),
    member(BluePosition, HousePositions),
    
    (   NorwegianPosition is BluePosition - 1; NorwegianPosition is BluePosition + 1),
    
    
    %the man who smokes blend has a neighbor who drinks water
    person_Beverage(Water, water),
    member(Water, Persons),
    person_HousePosition(Water, WaterPosition),
    member(WaterPosition, HousePositions),
    
    (   BlendPosition is WaterPosition - 1; BlendPosition is WaterPosition + 1),
    
    
    
    permutation(HouseColours,
		[BritHouseColour, SwedeHouseColour, DaneHouseColour, NorwegianHouseColour, GermanHouseColour]),
    permutation(HousePositions,
		[BritHousePosition, SwedeHousePosition, DaneHousePosition, NorwegianHousePosition, GermanHousePosition]),
    permutation(Beverages,
		[BritBeverage, SwedeBeverage, DaneBeverage, NorwegianBeverage, GermanBeverage]),
    permutation(Cigars,
		[BritCigar, SwedeCigar, DaneCigar, NorwegianCigar, GermanCigar]),
    permutation(Pets,
		[BritPet, SwedePet, DanePet, NorwegianPet, GermanPet]).
    

%Creating an extra predicate like this was the only way I could get prolog to not show the matrix for solution(Persons) alongside the actual answer
%It works out the nationality of the owner of the fish
owner(Persons, Owner) :-

    solution(Persons),
    
    person_Pet(FishOwner, fish),
    member(FishOwner, Persons),
    
    person_Nationality(FishOwner, FishOwnerNationality),
    Owner = FishOwnerNationality.


%The required predicate which will return the nationality of the owner of the fish
%Persons gives a singleton variable warning but I have silenced this
ownerOfFish(Persons, Owner) :-

    owner([_Brit, _Swede, _Dane, _Norwegian, _German], Owner).