namespace DotnetApiSkeleton.Domain
{
    using System;
    using System.Collections.Generic;

    using Models;
    public class WizardRetriever : IRetrieveWizards
    {
        public List<Wizard> Retrieve()
        {
            return new List<Wizard>()
            {
                new Wizard
                {
                    Name = "Gandalf the Grey",
                    Level = 99
                },
                new Wizard
                {
                    Name = "Merlin",
                    Level = 29
                },
                new Wizard
                {
                    Name = "Harry Potter",
                    Level = 32
                }
            };
        }
    }
}