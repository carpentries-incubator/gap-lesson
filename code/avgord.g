#####################################################################
#
# AvgOrdOfGroup(G)
#
# Calculating the average order of an element of G, where G meant to
# be a group but in fact may be any collection of objects having
# multiplicative order
#
AvgOrdOfCollection := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;


AvgOrdOfGroup := function(G)
local cc, sum, c;
cc:=ConjugacyClasses(G);
sum:=0;
for c in cc do
  sum := sum + Order( Representative(c) ) * Size(c);
od;
return sum/Size(G);
end;


TestOneGroup:= G -> IsInt( AvgOrdOfGroup(G) );


TestOneOrderEasy := function(n)
local i;
for i in [1..NrSmallGroups(n)] do
  if TestOneGroup( SmallGroup( n, i ) ) then
    return [n,i];
  fi;
od;
return fail;
end;


TestOneOrder := function(f,n)
local i, G;
for i in [1..NrSmallGroups(n)] do
  Print(n, ":", i, "/", NrSmallGroups(n), "\r");
  G := SmallGroup( n, i );
  if f(G) then
    Print("\n");
    return [n,i];
  fi;
od;
Print("\n");
return fail;
end;


TestAllOrders:=function(f,n)
local i, res;
for i in [2..n] do
  res:=TestOneOrder(f,i);
  if res <> fail then
    return res;
  fi;
od;
return fail;
end;


TestRangeOfOrders:=function(f,n1,n2)
local n, res;
for n in [n1..n2] do
  if not IsPrimePowerInt(n) then
     res:=TestOneOrder(f,n);
     if res <> fail then
       return res;
     fi;
   fi;
od;
return fail;
end;

InfoSmallGroupsSearch := NewInfoClass("InfoSmallGroupsSearch");

TestOneOrderVariadic := function(arg)
local f, n, n1, n2, i;

if not Length(arg) in [2..4] then
  Error("The number of arguments must be 2,3 or 4\n" );
fi;

if not IsFunction( arg[1] ) then
  Error("The first argument must be a function\n" );
else
  f := arg[1];
fi;

if not IsPosInt( arg[2] ) then
  Error("The second argument must be a positive integer\n" );
else
  n := arg[2];
fi;

if IsBound(arg[3]) then
  n1:=arg[3];
  if not n1 in [1..NrSmallGroups(n)] then
    Error("The 3rd argument must belong to ", [1..NrSmallGroups(n)], "\n" );
  fi;
else
  n1:=1;
fi;

if IsBound(arg[4]) then
  n2:=arg[4];
  if not n2 in [1..NrSmallGroups(n)] then
    Error("The 4th argument must belong to ", [1..NrSmallGroups(n)], "\n" );
  elif n2 < n1 then
    Error("The 4th argument must be greater or equal to the 3rd \n" );
  fi;
else
  n2:=NrSmallGroups(n);
fi;

Info( InfoSmallGroupsSearch, 1,
      "Checking groups ", n1, " ... ", n2, " of order ", n );
for i in [n1..n2] do
  if InfoLevel( InfoSmallGroupsSearch ) > 1 then
    Print(i, "/", NrSmallGroups(n), "\r");
  fi;
  if f(SmallGroup(n,i)) then
    Info( InfoSmallGroupsSearch, 1,
          "Discovered counterexample: SmallGroup( ", n, ", ", i, " )" );
    return [n,i];
  fi;
od;
Info( InfoSmallGroupsSearch, 1,
      "Search completed - no counterexample discovered" );
return fail;
end;


AverageOrder := NewAttribute("AverageOrder", IsCollection);

InstallMethod( AverageOrder,
  "for a collection",
  [IsCollection],
  AvgOrdOfCollection
);

InstallMethod( AverageOrder,
  "for a group",
  [IsGroup],
  AvgOrdOfGroup
);

IsIntegerAverageOrder := NewProperty("IsIntegerAverageOrder", IsCollection);

InstallMethod( IsIntegerAverageOrder,
  "for a collection",
  [IsCollection],
  coll -> IsInt( AverageOrder( coll ) )
);
