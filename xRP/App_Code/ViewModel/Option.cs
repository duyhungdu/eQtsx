namespace xRP
{
    public class Option
    {
        public string Name { get; set; }
        public int ID { get; set; }

        public Option() { }

        public Option(int id, string name)
        {
            this.ID = id;
            this.Name = name;
        }
    }
}
