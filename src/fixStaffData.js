export default function fixStaffData(s){
	s.title = s.description;
	s.phone = s.local;
	return s;
}
