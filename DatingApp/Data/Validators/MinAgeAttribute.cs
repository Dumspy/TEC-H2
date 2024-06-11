using System;
using System.ComponentModel.DataAnnotations;

public class MinAgeAttribute : ValidationAttribute
{
    private readonly int _minAge;

    public MinAgeAttribute(int minAge)
    {
        _minAge = minAge;
    }

    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        if (value is DateTime date)
        {
            var today = DateTime.Today;
            var minDate = today.AddYears(-_minAge);

            if (date <= minDate)
            {
                return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult($"You must be at least {_minAge} years old.");
            }
        }

        return new ValidationResult("Invalid date.");
    }
}