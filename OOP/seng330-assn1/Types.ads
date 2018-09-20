
package Types is
	type Position is (CENTER, GOALTENDER, WINGER, DEFENDER);
	subtype Name_String is String(1 .. 20);
	Max_Players : Positive := 22; -- Standard hockey team size
	Max_Teams   : Positive := 32; -- 31 + Seattle Metropolitans
end Types;
