public class EvergreenDocumentModel {
	public Potentiallead potentiallead;
	public List<Attachments> attachments;

	public class Potentiallead {
		public String PotentialLeadID;
	}

	public class Attachments {
		public String Body;
		public String ContentType;
		public String Name;
	}
}