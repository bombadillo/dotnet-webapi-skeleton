namespace DotnetApiSkeleton.Domain
{
    using System;
    using System.Collections.Generic;

    using Models;
    public class WizardRetriever : IRetrieveWizards
    {
        private readonly ILog Logger;

        public WizardRetriever(ILog logger)
        {
            Logger = logger;
        }

        public List<Wizard> Retrieve()
        {
            Logger.Info("Retrieving wizards");

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